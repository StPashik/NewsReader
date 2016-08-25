//
//  UIImageView+StLib.swift
//  Behterev
//
//  Created by StPashik on 20.04.15.
//  Copyright (c) 2015 Legion. All rights reserved.
//

import UIKit
import Foundation

private let _sharedCache = ImageCache()

class ImageCache {
    
    private var imagesArray = [String: UIImage]()
    private var keysArray = [String]()
    
    class var sharedCache: ImageCache
    {
        return _sharedCache
    }
    
    internal func addImage(image: UIImage, key: String)
    {
        keysArray.append(key)
        imagesArray[key] = image
        
        clearCash()
    }
    
    internal func getImage(key: String) -> UIImage?
    {
        guard let image = imagesArray[key] else {
            return nil
        }
        
        return image
    }
    
    private func clearCash()
    {
        if keysArray.count > 40 {
            for _ in 0..<10 {
                imagesArray.removeValueForKey(keysArray.first!)
                keysArray.removeFirst()
            }
        }
    }
}

extension UIImageView {
    /**
    Загрузка изображения по URL адресу и вставка как только закончится загрузка.
    
    :param: urlString Адрес используемый для загрузки изображения.
    */
    public func imageFromUrl(urlString: String)
    {
        imageFromUrl(urlString, placeholder: nil)
    }
    
    /**
    Загрузка изображения с URL адреса и вставка как только закончится загрузка.
    
    Если изображение закэшированио, оно будет вставленно немедленно без дополнительной загрузки и не показывая заглушку.
    
    :param: urlString   Адрес используемый для загрузки изображения.
    :param: placeholder Изображение которое будет вставлено при инициализации пока основное изображение не загрузиться. Если установлен 'nil', то изображение не будет меняться, пока не закончиться загрузка.
    */
    public func imageFromUrl(urlString: String, placeholder: UIImage?)
    {
        imageFromUrl(urlString, placeholder: placeholder, success: nil, failure: nil)
    }
    
    /**
    Загрузка изображения с URL адреса и вставка как только закончится загрузка.
    
    :param: urlString   Адрес используемый для загрузки изображения.
    :param: placeholder Изображение которое будет вставлено при инициализации пока основное изображение не загрузиться. Если установлен 'nil', то изображение не будет меняться, пока не закончиться загрузка.
    :param: success     Блок который выполниться по завершению загрузки и вернёт загруженное изображение. Если установлен 'nil', то блок вызываться не будет.
    :param: failure     Блок который выполниться если возникнет ошибка после запроса и вернёт ошибку. Если установлен 'nil', то блок вызываться не будет.
    */
    public func imageFromUrl(urlString: String, placeholder:UIImage?, success:((image: UIImage!) -> Void)?, failure:((NSError!) -> Void)?)
    {
        getCachedImageByUrl(urlString) { (image) -> Void in
            
            self.image = nil
            
            if image != nil {
                if success != nil {
                    success!(image: image)
                }
                
                self.image = image
            } else {
                if let _ = placeholder {
                    self.image = placeholder
                }
                
                if let url = NSURL(string: urlString) {
                    let request = NSURLRequest(URL: url)
                    NSURLConnection.sendAsynchronousRequest(request, queue: .mainQueue(), completionHandler: { (response, data, error) -> Void in
                        if data != nil {
                            let image = UIImage(data: data!)
                            self.image = image != nil ? image : placeholder
                            
                            if image != nil {
                                self.cashImageWithURL(urlString, image: image!)
                            }
                            
                            if (success != nil) {
                                success!(image: image)
                            }
                        }
                        
                        if error != nil {
                            if (failure != nil) {
                                failure!(error)
                            }
                        }
                    })
                }
            }
            
        }
    }
    
    /**
    Возвращает закэшированое изображение по адресу, если такое имеется.
    
    :param: url Адрес запроса изображения.
    
    :returns: Кэшированое изображение.
    */
    public func getCachedImageByUrl(urlString: String, complete:((image: UIImage!) -> Void)?)
    {
        if let image = ImageCache.sharedCache.getImage(urlString.MD5()) {
            if (complete != nil) {
                complete!(image: image)
            }
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                let cashedImageName:String     = urlString.MD5()
                let paths:Array                = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)
                let documentsDirectory: String = paths[0]
                let fileExtension:String       = NSString(string: urlString).pathExtension
                let filePath:String            = "\(documentsDirectory)/\(cashedImageName).\(fileExtension)"
                let image:UIImage?             = UIImage(contentsOfFile: filePath)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if (image != nil) {
                        ImageCache.sharedCache.addImage(image!, key: cashedImageName)
                    }
                    
                    if (complete != nil) {
                        
                        complete!(image: image)
                    }
                })
            })
        }
    }
    
    /**
    Кэширование изображения по его запросу.
    
    :param: url   Адрес кэшируемого изображения.
    :param: image Кэшируемое изображение.
    */
    public func cashImageWithURL(urlString: String, image:UIImage)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let cashedImageName:String = urlString.MD5()
            let documentsPath          = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]
            let fileExtension:String   = NSString(string: urlString).pathExtension
            let destinationPath        = NSString(string: documentsPath).stringByAppendingPathComponent("\(cashedImageName).\(fileExtension)")
            
            ImageCache.sharedCache.addImage(image, key: cashedImageName)
            
            UIImageJPEGRepresentation(image,1.0)!.writeToFile(destinationPath, atomically: true)
        })
    }
}
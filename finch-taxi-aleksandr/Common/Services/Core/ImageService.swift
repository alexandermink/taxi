//
//  ImageService.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 01.03.2022.
//

import UIKit

protocol ImageServiceInput {
    func getImage(forKey key: String) -> UIImage?
    func saveImage(_ image: UIImage, forKey key: String, completion: @escaping (Error) -> Void)
    func deleteImage(forKey key: String, completion: @escaping (Error) -> Void)
    func clearImagesDirectory(completion: @escaping (Error) -> Void)
}

final class ImageService {
    
    // MARK: - Locals
    
    private enum Locals {
        static let cashImagesDirectoryPrefix = "UserSession/Cash/Images/"
    }
    
    // MARK: - Properties
    
    private let fileManager: FileManager
    
    
    // MARK: - Init
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }
    
    
    // MARK: - Private methods
    
    private func composeFileURL(withName name: String) -> URL? {
        
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        if !fileManager.fileExists(atPath: url.appendingPathComponent(Locals.cashImagesDirectoryPrefix).path) {
            do {
                try fileManager.createDirectory(
                    atPath: url.appendingPathComponent(Locals.cashImagesDirectoryPrefix).path,
                    withIntermediateDirectories: true
                )
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return url.appendingPathComponent(Locals.cashImagesDirectoryPrefix)
                  .appendingPathComponent(name)
    }
}


// MARK: - ProfileNetworkServiceInput
extension ImageService: ImageServiceInput {
    
    func getImage(forKey key: String) -> UIImage? {
        
        if let url = composeFileURL(withName: key),
           let imageData = fileManager.contents(atPath: url.path),
           let image = UIImage(data: imageData) {
            return image
        }
        return nil
    }
    
    func saveImage(_ image: UIImage, forKey key: String, completion: @escaping (Error) -> Void) {
        
        if let pngData = image.pngData(), let url = composeFileURL(withName: key) {
            do  {
                try pngData.write(to: url)
            } catch let error {
                completion(error)
            }
        }
        
    }
    
    func deleteImage(forKey key: String, completion: @escaping (Error) -> Void) {
        
        if let url = composeFileURL(withName: key) {
            do  {
                try fileManager.removeItem(atPath: url.path)
            } catch let error {
                completion(error)
            }
        }
    }
    
    func clearImagesDirectory(completion: @escaping (Error) -> Void) {
        
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        do {
            try fileManager.removeItem(atPath: url.appendingPathComponent(Locals.cashImagesDirectoryPrefix).path)
        } catch let error {
            completion(error)
        }
    }
    
}

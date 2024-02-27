//
//  NewsTableViewCell.swift
//  News App
//
//  Created by Молтабаров Аманжол on 22.02.2024.
//

import UIKit

class NewsTableViewCellViewModel {
    let article: Article
    let isSaved: Bool
    var imageData: Data? = nil

    init(
        article: Article,
        isSaved: Bool
    ) {
        self.isSaved = isSaved
        self.article = article
    }
}


class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    private var article: Article?
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Proxima Nova", size: 17)
    
        
        return label
    }()

    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let newsSavedView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bookmark"))
        
        return imageView
    }()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsSavedView)
        contentView.backgroundColor = .white
        
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0).cgColor
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewsTableViewCell.imageTapped))
        newsSavedView.isUserInteractionEnabled = true
        newsSavedView.addGestureRecognizer(tapGestureRecognizer)

    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        
        newsTitleLabel.frame = CGRect(
            x: 10,
            y: 10,
            width: contentView.frame.size.width - 170,
            height: 70
        )
        
        newsSavedView.frame = CGRect(x: 10, y: 80, width: 30, height: 30)
        
        newsImageView.frame = CGRect(
            x: contentView.frame.size.width - 120,
            y: 12,
            width: 108,
            height: contentView.frame.size.height - 25
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsImageView.image = nil
        newsSavedView.image = UIImage(systemName: "bookmark")
        newsSavedView.tintColor = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1.0)
    }
    
    @objc func imageTapped(){
        if let data = article{
            let isSaved = DBController.shared.saveOrDeleteArticle(article: data)
            if isSaved{
                newsSavedView.image = UIImage(systemName: "bookmark.fill")
                newsSavedView.tintColor = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1.0)
            }else{
                newsSavedView.image = UIImage(systemName: "bookmark")
                newsSavedView.tintColor = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1.0)
           
            }
        }
    }

    func configure(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.article.title
        article = viewModel.article
        
        if viewModel.isSaved{
            newsSavedView.image = UIImage(systemName: "bookmark.fill")
            newsSavedView.tintColor = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1.0)
        }

        // Image
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = URL(string: viewModel.article.urlToImage ?? "") {
            // fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }

}



//
//  CategoryCardCell.swift
//  Ello
//
//  Created by Colin Gray on 6/17/2016.
//  Copyright (c) 2016 Ello. All rights reserved.
//

import SnapKit

public class CategoryCardCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoryCardCell"

    var title: String {
        set { label.text = newValue }
        get { return label.text ?? "" }
    }
    var imageURL: NSURL? {
        didSet {
            imageView.pin_setImageFromURL(imageURL)
        }
    }

    private let label = ElloLabel()
    private let colorFillView = UIView()
    private let imageView = UIImageView()

    override public init(frame: CGRect) {
        super.init(frame: frame)

        style()
        arrange()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        label.text = ""
        imageView.image = nil
    }

    private func style() {
        label.textColor = .whiteColor()
        colorFillView.backgroundColor = .blackColor()
        colorFillView.alpha = 0.5
    }

    private func arrange() {
        contentView.addSubview(imageView)
        contentView.addSubview(colorFillView)
        contentView.addSubview(label)

        colorFillView.snp_makeConstraints { make in
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-2)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
        }
        imageView.snp_makeConstraints { make in
            make.edges.equalTo(colorFillView)
        }
        label.snp_makeConstraints { make in
            make.centerX.centerY.equalTo(colorFillView)
        }
    }
}

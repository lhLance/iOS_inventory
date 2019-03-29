//
//  CloumnFirstCategorTableViewCell.swift
//  Fii
//
//  Created by yetao on 2019/3/14.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit

class CloumnFirstCategorTableViewCell: UITableViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var detailLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.black
        lab.textAlignment = NSTextAlignment.center
        lab.font = UIFont.boldSystemFont(ofSize: 16)
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    private func setupView(){

        self.contentView.backgroundColor = UIColor.lightGray

        self.contentView.addSubview(cellView)
        cellView.addSubview(detailLab)
        selectionStyle = .none
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        cellView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(1)
            ConstraintMaker.leading.equalToSuperview().offset(10)
            ConstraintMaker.bottom.equalToSuperview().offset(-1)
            ConstraintMaker.trailing.equalToSuperview().offset(-10)
            
            
        detailLab.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.left.equalToSuperview().offset(5)
            ConstraintMaker.right.equalToSuperview().offset(-5)
            ConstraintMaker.top.equalToSuperview().offset(5)
            ConstraintMaker.bottom.equalToSuperview().offset(-5)
        })

            
        }
        // Configure the view for the selected state
    }
}

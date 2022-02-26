//
//  ReaderInfoPageView.swift
//  Aidoku (iOS)
//
//  Created by Skitty on 1/22/22.
//

import UIKit

enum ReaderInfoPageType {
    case previous
    case next
}

class ReaderInfoPageView: UIView {
    var type: ReaderInfoPageType

    let currentChapter: Chapter
    var previousChapter: Chapter? {
        didSet {
            updateLabelText()
        }
    }
    var nextChapter: Chapter? {
        didSet {
            updateLabelText()
        }
    }

    let noChapterLabel = UILabel()

    let stackView = UIStackView()
    let topChapterLabel = UILabel()
    let topChapterTitleLabel = UILabel()
    let bottomChapterLabel = UILabel()
    let bottomChapterTitleLabel = UILabel()

    init(type: ReaderInfoPageType, currentChapter: Chapter) {
        self.type = type
        self.currentChapter = currentChapter

        super.init(frame: .zero)

        backgroundColor = .systemBackground

        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let topStackView = UIStackView()
        topStackView.distribution = .equalSpacing
        topStackView.axis = .vertical
        topStackView.spacing = 2
        topChapterLabel.textColor = .label
        topChapterLabel.font = .systemFont(ofSize: 16, weight: .medium)
        topChapterTitleLabel.textColor = .secondaryLabel
        topChapterTitleLabel.font = .systemFont(ofSize: 16)
        topChapterTitleLabel.numberOfLines = 0

        let bottomStackView = UIStackView()
        bottomStackView.distribution = .equalSpacing
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 2
        bottomChapterLabel.textColor = .label
        bottomChapterLabel.font = .systemFont(ofSize: 16, weight: .medium)
        bottomChapterTitleLabel.textColor = .secondaryLabel
        bottomChapterTitleLabel.font = .systemFont(ofSize: 16)
        bottomChapterTitleLabel.numberOfLines = 0

        topStackView.addArrangedSubview(topChapterLabel)
        topStackView.addArrangedSubview(topChapterTitleLabel)
        bottomStackView.addArrangedSubview(bottomChapterLabel)
        bottomStackView.addArrangedSubview(bottomChapterTitleLabel)

        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(bottomStackView)

        addSubview(stackView)

        noChapterLabel.textColor = .secondaryLabel
        noChapterLabel.textAlignment = .center
        noChapterLabel.font = .systemFont(ofSize: 16)
        noChapterLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(noChapterLabel)

        noChapterLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noChapterLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 1, constant: -64).isActive = true

        updateLabelText()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateLabelText() {
        if let previousChapter = previousChapter {
            topChapterLabel.text = "Previous:"
            topChapterTitleLabel.text = String(format: "Ch.%g - \(previousChapter.title ?? "No title")",
                                               previousChapter.chapterNum ?? 0)
            bottomChapterLabel.text = "Current:"
            bottomChapterTitleLabel.text = String(format: "Ch.%g - \(currentChapter.title ?? "No title")",
                                                  currentChapter.chapterNum ?? 0)
            noChapterLabel.isHidden = true
            stackView.isHidden = false
        } else if let nextChapter = nextChapter {
            topChapterLabel.text = "Finished:"
            topChapterTitleLabel.text = String(format: "Ch.%g - \(currentChapter.title ?? "No title")",
                                               currentChapter.chapterNum ?? 0)
            bottomChapterLabel.text = "Next:"
            bottomChapterTitleLabel.text = String(format: "Ch.%g - \(nextChapter.title ?? "No title")",
                                                  nextChapter.chapterNum ?? 0)
            noChapterLabel.isHidden = true
            stackView.isHidden = false
        } else {
            noChapterLabel.text = "There's no \(type == .previous ?  "previous" : "next") chapter"
            stackView.isHidden = true
            noChapterLabel.isHidden = false
        }
    }
}

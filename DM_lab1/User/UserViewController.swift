import UIKit
import AlamofireImage

class UserViewController: UIViewController, Reusable {

    var user: User? {
        didSet {
            setData()
        }
    }

    var wireframe: Wireframe? {
        didSet {
            if let view = self.view as? TwitterUserProfileView {
                view.wireframe = self.wireframe
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
    }


    func setData() {
        if let view = self.view as? TwitterUserProfileView, let user = user {
            view.avatarImageView.af_setImage(withURL: URL(string: user.avatarURL)!)

            if let bannerURL = user.bannerURL {
                view.bannerImageView.af_setImage(withURL: URL(string: bannerURL)!)
            }

            view.nameLabel.text = user.name
            view.screenNameLabel.text = "@" + user.screenName
            view.descriptionLabel.text = user.description

            view.tweetsCountLabel.text = "\(user.statusesCount)"
            view.followingCountLabel.text = "\(user.followersCount)"
            view.followersCountLabel.text = "\(user.friendsCount)"
            view.likesCountLabel.text = "\(user.favouritesCount)"
        }
    }

}

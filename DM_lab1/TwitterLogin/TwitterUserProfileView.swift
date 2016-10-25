import UIKit

class TwitterUserProfileView: UIView, Reusable {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!

    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!

    var containedView: UIView?

    var wireframe: Wireframe?

    @IBAction func buttonPressed(_ sender: AnyObject) {
        let document = CouchbaseGateway.instance.document

        print(document.properties)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let view = UIView.createWithDefaultIdentifier(owner: self, identifier: TwitterUserProfileView.reuseIdentifier)
        if let view = view {
            self.addSubview(view)

            containedView = view
        }
    }

    override func layoutSubviews() {
        if let containedView = containedView {
            containedView.frame = self.bounds
        }
    }

}

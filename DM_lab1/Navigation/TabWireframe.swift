import UIKit

class TabWireframe: Wireframe {

    unowned let viewController: UIViewController
    let rootTabBarController: UITabBarController

    let parentWireframe: Wireframe?

    let userViewController: UserViewController
    let moviesViewController: MoviesViewController
    let weatherViewController: WeatherViewController

    init(parentWireframe: Wireframe, user: User) {
        self.parentWireframe = parentWireframe

        self.userViewController = UIViewController.createWithDefaultIdentifier()
        userViewController.tabBarItem = UITabBarItem(title: userViewController.title, image: UIImage(named: "UserUnselected"), selectedImage: UIImage(named: "User"))
        userViewController.user = user

        self.moviesViewController = UIViewController.createWithDefaultIdentifier()
        moviesViewController.tabBarItem = UITabBarItem(title: moviesViewController.title, image: UIImage(named: "MovieUnselected"), selectedImage: UIImage(named: "Movie"))

        self.weatherViewController = UIViewController.createWithDefaultIdentifier()
        weatherViewController.tabBarItem = UITabBarItem(title: weatherViewController.title, image: UIImage(named: "VideoUnselected"), selectedImage: UIImage(named: "Video"))

        rootTabBarController = UITabBarController()
        rootTabBarController.viewControllers = [userViewController, moviesViewController, weatherViewController]

        viewController = rootTabBarController

        userViewController.wireframe = self
    }

}

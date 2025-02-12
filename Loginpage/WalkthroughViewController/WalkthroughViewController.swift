//
//  RootViewController.swift
//  Loginpage
//
//  Created by IE13 on 06/11/23.
//

import UIKit
class WalkthroughViewController: UIViewController {
    private var pageViewController: UIPageViewController!
    @IBOutlet private var skipButton: UIButton!
    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var nextButton: UIButton!
    private var index: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        skipButton.layer.cornerRadius = 8
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    var viewControllerList: [UIViewController] = {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let firstPageViewController = storyBoard.instantiateViewController(withIdentifier: "FirstPageViewController")
        let secondPageViewController = storyBoard.instantiateViewController(withIdentifier: "SecondPageViewController")
        let thirdPageViewController = storyBoard.instantiateViewController(withIdentifier: "ThirdPageViewController")
        return [firstPageViewController, secondPageViewController, thirdPageViewController]
    }()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PageViewController" {
            pageViewController = segue.destination as? UIPageViewController
            if let firstViewController = viewControllerList.first {
                pageViewController.setViewControllers([firstViewController],
                direction: .forward, animated: true, completion: nil)
            }
        }
    }
    @IBAction func nextPageViewAction(_ sender: Any) {
        if index>=viewControllerList.count {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
        if let viewController = viewControllerList[index] as? UIViewController {
        pageViewController.setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
            pageControl.currentPage = index
            index += 1
        }
        if index >= viewControllerList.count {
            skipButton.isHidden = true
        }
    }
    @IBAction func skipButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        navigationController?.pushViewController(viewController, animated: true)
        return
    }
}
extension WalkthroughViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {
            return nil }
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else { return nil}
        guard viewControllerList.count > nextIndex else { return nil }
        return viewControllerList[nextIndex]
    }
    func pageViewController( _ pageViewController: UIPageViewController,
                             viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.firstIndex(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        return viewControllerList[previousIndex]
    }
}
extension WalkthroughViewController: UIPageViewControllerDelegate {
      func pageViewController(_ pageViewController: UIPageViewController,
                              didFinishAnimating finished: Bool,
                              previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentPageViewController = pageViewController.viewControllers?.first {
          let indexAccess = viewControllerList.firstIndex(of: currentPageViewController)!
          pageControl?.currentPage = indexAccess
            index = indexAccess + 1
        }
      }
    }

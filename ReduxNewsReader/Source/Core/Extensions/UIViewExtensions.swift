extension UIView {

    func recursiveShowAnimatedSkeleton(view: UIView) {
        view.subviews.forEach {
            recursiveShowAnimatedSkeleton(view: $0)
        }
        view.isSkeletonable = true
        view.showAnimatedSkeleton(
            usingColor: Asset.Colors.lightGray.color,
            animation: nil,
            transition: .none
        )
    }
    
    func recursiveHideAnimatedSkeleton(view: UIView) {
        view.subviews.forEach {
            recursiveHideAnimatedSkeleton(view: $0)
        }
        view.isSkeletonable = false
        view.hideSkeleton(reloadDataAfter: false, transition: .none)
    }
}

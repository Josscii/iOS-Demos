//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import "WYTabView.h"
#import "WYSimpleTabItemView.h"


//let maxOffsetX = collectionView.contentSize.width - collectionView.bounds.width
//
//// if the collectionView can't scroll, we just complete and return
//if maxOffsetX < 0 {
//    completion()
//    return
//}
//
//// if the cell at index is here, just in case
//guard let frame = frameForCell(at: index) else {
//    return
//}
//
//// x must > 0 and < max offset x
//let x = min(max(frame.midX - collectionView.bounds.width / 2, 0), maxOffsetX)
//
//UIView.animate(withDuration: animationDuration) {
//    self.collectionView.contentOffset.x = x
//    }

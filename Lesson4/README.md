设置navigationbar和statusBar的颜色透明

navigationBar的backgroundImage属性。


从reveal中可以看到navigationbar的frame是(0,20,375,44)。但是navigationbar的backgroundImage却是从(0,-20)开始的，如果换成相对viewController的坐标，那么backgroundImage的frame是(0,0,375,64)。所以设置navigationBar的backgroundImage就可以实现navigationBar和statusBar一起变色的效果。

注意：设置backgroundColor并没有效果
下图是设置了navigationbar的backgroundColor为红色时的reveal效果图。可以明显的看到只是影响了(0,20)开始的区域，并没有影响从(0,0)开始，但是注意，如果想要实现navigationBar和statusBar透明的效果，需要将navigationbar的backgroundColor设置为[UIColor clearColor].



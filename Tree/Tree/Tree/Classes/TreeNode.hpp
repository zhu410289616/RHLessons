//
//  TreeNode.hpp
//  Tree
//
//  Created by zhuruhong on 2017/4/19.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#ifndef TreeNode_hpp
#define TreeNode_hpp

#include <stdio.h>

class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    
public:
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

#endif /* TreeNode_hpp */

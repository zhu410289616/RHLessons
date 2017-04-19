//
//  Solution.hpp
//  Tree
//
//  Created by zhuruhong on 2017/4/19.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#ifndef Solution_hpp
#define Solution_hpp

#include <stdio.h>
#include <vector>
#include "TreeNode.hpp"

//http://blog.csdn.net/terence1212/article/details/52182836

using namespace std;

class Solution {
public:
    //后序遍历
    //非递归
    vector<int> postorderTraversal(TreeNode *root);
    vector<int> postorderTraversal2(TreeNode *root);

public:
    //中序遍历
    //非递归
    vector<int> inorderTraversal(TreeNode *root);
    //递归
    vector<int> inorderTraversal2(TreeNode *root);
private:
    void inorder(TreeNode *p, vector<int> &ret);
    
public:
    //前序遍历
    //非递归
    vector<int> preorderTraversal(TreeNode *root);
    //递归
    vector<int> preorderTraversal2(TreeNode *root);
private:
    void dfsPreOrder(TreeNode *root, vector<int> &ret);
};

#endif /* Solution_hpp */

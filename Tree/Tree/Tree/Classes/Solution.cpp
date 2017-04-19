//
//  Solution.cpp
//  Tree
//
//  Created by zhuruhong on 2017/4/19.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#include "Solution.hpp"
#include <stack>

vector<int> Solution::postorderTraversal(TreeNode *root) {
    vector<int> ret;
    if (NULL == root) {
        return ret;
    }
    stack<TreeNode *> st;
    st.push(root);
    while (!st.empty()) {
        TreeNode *tmp = st.top();
        ret.push_back(tmp->val);//先访问根节点
        st.pop();
        if (NULL != tmp->left) {
            st.push(tmp->left);//再访问左子树
        }
        if (NULL != tmp->right) {
            st.push(tmp->right);
        }
    }
    reverse(ret.begin(), ret.end());//将结果反序输出
    return ret;
}

vector<int> Solution::postorderTraversal2(TreeNode *root) {
    vector<int> ret;
    TreeNode *p = root;
    stack<TreeNode *> st;
    TreeNode *r = NULL;
    while (p || !st.empty()) {
        if (p) {
            st.push(p);
            p = p->left;
        } else {
            p = st.top();
            if (p->right && p->right != r) {
                p = p->right;
                st.push(p);
                p = p->left;
            } else {
                p = st.top();
                st.pop();
                ret.push_back(p->val);
                r = p;
                p = NULL;
            }
        }
    }
    return ret;
}

vector<int> Solution::inorderTraversal(TreeNode *root) {
    vector<int> ret;
    TreeNode *p = root;
    stack<TreeNode *> st;
    while (!st.empty() || NULL != p) {
        if (p) {//p非空，代表还有左子树
            st.push(p);
            p = p->left;
        } else {//如果为空，代表左子树已经走到尽头
            p = st.top();
            st.pop();
            ret.push_back(p->val);//访问栈顶元素
            if (p->right) {
                st.push(p->right);//如果存在右子树，将右子树入栈
                p = p->right->left;//p始终为下一个待访问的节点
            } else {
                p = NULL;
            }
        }
    }
    return ret;
}

vector<int> Solution::inorderTraversal2(TreeNode *root) {
    vector<int> ret;
    inorder(root, ret);
    return ret;
}

void Solution::inorder(TreeNode *p, vector<int> &ret) {
    if (NULL == p) {
        return;
    }
    inorder(p->left, ret);
    ret.push_back(p->val);
    inorder(p->right, ret);
}

//非递归
vector<int> Solution::preorderTraversal(TreeNode *root) {
    vector<int> ret;
    if (NULL == root) {
        return ret;
    }
    stack<TreeNode *> st;
    st.push(root);
    while (!st.empty()) {
        TreeNode *tp = st.top();//取出栈顶元素
        st.pop();
        ret.push_back(tp->val);//先访问根节点
        if (NULL != tp->right) {
            st.push(tp->right);//
        }
        if (NULL != tp->left) {
            st.push(tp->left);//将左子树压栈
        }
    }
    return ret;
}

//递归
vector<int> Solution::preorderTraversal2(TreeNode *root) {
    vector<int> ret;
    dfsPreOrder(root, ret);
    return ret;
}

void Solution::dfsPreOrder(TreeNode *root, vector<int> &ret) {
    if (NULL == root) {
        return;
    }
    ret.push_back(root->val);//存储根节点
    if (NULL != root->left) {
        dfsPreOrder(root->left, ret);//访问左子树
    }
    if (NULL != root->right) {
        dfsPreOrder(root->right, ret);//访问右子树
    }
}

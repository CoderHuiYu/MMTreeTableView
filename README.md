# MMTreeTableView
## 一个轻量级、 可配置、可以自定义每个层级的UI、简单易用的一个目录组件
<img width="1014" alt="title_trr" src="https://user-images.githubusercontent.com/18704047/156887573-1c8bde3b-77df-43b3-975d-2e492da6cb47.png">


## 一.核心原理
1. 本质上是一颗多叉树
2. 使用的是前序遍历来完成每个节点的数据配置
3. 通过代理的方式来让使用方来自定义UI

## 二.Image and gif
![demogif](https://user-images.githubusercontent.com/18704047/156888461-f194e366-431c-429b-a1d5-21651ae9aa88.gif)


## 三.怎么样使用 
### 3.1. 首先需要根据数据源来构建数据结构
#### 举例：
```swift
 private func constructionFileTree() {

        let root = MMNode(element: Model(title: "世界国家"))

        let node1 = MMNode(element: Model(title: "中国"))
        let node1_1 = MMNode(element: Model(title: "杭州"))
        let node1_2 = MMNode(element: Model(title: "上海"))
        let node1_3 = MMNode(element: Model(title: "深圳"))
        node1.add([ node1_1, node1_2, node1_3 ])


        let nodeCity = MMNode(element: Model(title: "北京"), parent: node1)
        let nodeCity_1 = MMNode(element: Model(title: "朝阳"), parent: nodeCity)
        let nodeCity_2 = MMNode(element: Model(title: "海淀"), parent: nodeCity)
        let nodeCity_3 = MMNode(element: Model(title: "东城"), parent: nodeCity)

        nodeCity.add([ nodeCity_1, nodeCity_2, nodeCity_3 ])
        node1.add(nodeCity)

        let node2 = MMNode(element: Model(title: "美国"), parent: root)
        let node2_1 = MMNode(element: Model(title: "纽约"), parent: node2)
        let node2_2 = MMNode(element: Model(title: "华盛顿"), parent: node2)
        let node2_3 = MMNode(element: Model(title: "加利福利亚"), parent: node2)
        node2.add([ node2_1, node2_2, node2_3 ])

        let node3 = MMNode(element: Model(title: "英国"), parent: root)
        let node3_1 = MMNode(element: Model(title: "伦敦"), parent: node3)
        let node3_2 = MMNode(element: Model(title: "爱丁堡"), parent: node3)
        let node3_3 = MMNode(element: Model(title: "剑桥"), parent: node3)
        node3.add([ node3_1, node3_2, node3_3 ])
        
        root.add([ node1, node2, node3 ])

        let fileTree = MMFileTree<Model>(root: root)
        treeView.fileTree = fileTree
    }
```
### 3.2. 创建treeView，以及配置参数，这些参数都是可选的
 * 这里的option是可以配置的，目前只有3项,如下

```swift
public enum Option {
    case expandForever(Bool) // 是否一直展开
    case startDepth(Int)     // 可以选择展开的树的深度，比如一进来就展开到树深度为2的位置
    case indentationWidth(CGFloat) // 每一个层级的缩进宽度
}
```
```swift
 private lazy var treeView: MMTreeTableView<Model> = {
        let expand = Option.expandForever(true)
        let startDepth = Option.startDepth(1)
        let indentation = Option.indentationWidth(30.0)
// 这里的option是可以配置的，目前只有3项
        let result = MMTreeTableView<Model>(options: [ startDepth, indentation ], frame: .zero, style: .plain)
        result.treeDelegate = MMTreeDelegateThunk(base: self)
        result.backgroundColor = .green.withAlphaComponent(0.2)
        return result
    }()
```

### 3.3 让VC遵循代理
为了让使用者可以配置每一个树的UI，所以使用泛型以及类型擦除，将数据抛出来，使用者只需要在`func nodeView(numberOfItems item: Int, model element: Model, nodeView view: MMTreeTableView<Model>) -> UIView` 这个代理方法里进行UI创建和配置即可。
```swift
extension ViewController: MMTreeTableViewDelegate {

    typealias T = Model
    func nodeView(numberOfItems item: Int, model element: Model, nodeView view: MMTreeTableView<Model>) -> UIView {
        let result = UILabel()
        result.heightAnchor.constraint(equalToConstant: 50).isActive = true
        result.text = "\(element.title)"
        return result
    }

    func tableView(_ treeTableView: MMTreeTableView<Model>, didSelectRowAt indexPath: IndexPath) {
        print("----\(indexPath.item)----")
    }
}
```
### 四. 集成
* Installation with CocoaPods：`pod 'MMTreeTableView', '~> 1.1.0'`

## Remind
* ARC
* iOS>=11.0

## If you have any questions 
#### If you have any questions, you can email to me:171364980@qq.com 


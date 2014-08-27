import org.philhosoft.collection { ... }
import ceylon.test { test, assertEquals }

SimpleTreeNode<String> root = SimpleTreeNode("Root",
		SimpleTreeNode("A",
			SimpleTreeNode("a C",
				SimpleTreeNode("c F"),
				SimpleTreeNode("c G")
			),
			SimpleTreeNode("a D")
		),
		SimpleTreeNode("B",
			SimpleTreeNode("b E",
				SimpleTreeNode("e H")
			)
		)
	).attach();

SimpleTreeNode<String> singleNode = SimpleTreeNode("Single");

object treeTraversal extends TreeTraversal<TreeNode<String>>()
{
	shared actual {TreeNode<String>*} children(TreeNode<String> root) => root.children;
}

test void testSingleNodeTreeTraversalPreOrder()
{
	value tt = treeTraversal.preOrderTraversal(singleNode);
	value result = [ for (tn in tt) tn.element ];
	assertEquals(result, [ "Single" ]);
}

test void testSingleNodeTreeTraversalPostOrder()
{
	value tt = treeTraversal.postOrderTraversal(singleNode);
	value result = [ for (tn in tt) tn.element ];
	assertEquals(result, [ "Single" ]);
}

test void testSingleNodeTreeTraversalBreadthFirst()
{
	value tt = treeTraversal.breadthFirstTraversal(singleNode);
	value result = [ for (tn in tt) tn.element ];
	assertEquals(result, [ "Single" ]);
}

test void testTreeTraversalPreOrder()
{
	value tt = treeTraversal.preOrderTraversal(root);
	value result = [ for (tn in tt) tn.element ];
	assertEquals(result, [ "Root", "A", "a C", "c F", "c G", "a D", "B", "b E", "e H" ]);
}

test void testTreeTraversalPostOrder()
{
	value tt = treeTraversal.postOrderTraversal(root);
	value result = [ for (tn in tt) tn.element ];
	assertEquals(result, [ "c F", "c G", "a C", "a D", "A", "e H", "b E", "B", "Root" ]);
}

test void testTreeTraversalBreadthFirst()
{
	value tt = treeTraversal.breadthFirstTraversal(root);
	value result = [ for (tn in tt) tn.element ];
	assertEquals(result, [ "Root", "A", "B", "a C", "a D", "b E", "c F", "c G", "e H" ]);
}

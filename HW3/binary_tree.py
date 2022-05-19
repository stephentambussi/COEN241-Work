from mininet.topo import Topo

class BinaryTreeTopo( Topo ):
    "Binary Tree Topology Class."

    def __init__( self ):
        "Create the binary tree topology."

        # Initialize topology
        Topo.__init__( self )

	# Add hosts

	# Add switches

	# Add links

topos = { 'binary_tree': ( lambda: BinaryTreeTopo() ) }

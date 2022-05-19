from mininet.topo import Topo
# 7 switches, 8 hosts
class BinaryTreeTopo( Topo ):
    "Binary Tree Topology Class."

    def __init__( self ):
        "Create the binary tree topology."

        # Initialize topology
        Topo.__init__( self )

        # Add hosts
        host1 = self.addHost('h1')
        host2 = self.addHost('h2')
        host3 = self.addHost('h3')
        host4 = self.addHost('h4')
        host5 = self.addHost('h5')
        host6 = self.addHost('h6')
        host7 = self.addHost('h7')
        host8 = self.addHost('h8')

        # Add switches
        switch1 = self.addSwitch('s1')
        switch2 = self.addSwitch('s2')
        switch3 = self.addSwitch('s3')
        switch4 = self.addSwitch('s4')
        switch5 = self.addSwitch('s5')
        switch6 = self.addSwitch('s6')
        switch7 = self.addSwitch('s7')

        #Switch to switch links
        # s2 <-- s1 --> s5
        self.addLink(switch2, switch1) 
        self.addLink(switch1, switch5)
        # s3 <-- s2 --> s4
        self.addLink(switch3, switch2)
        self.addLink(switch2, switch4)
        # s6 <-- s5 --> s7
        self.addLink(switch6, switch5)
        self.addLink(switch5, switch7)

        #Switch to host links
        # h1 <-- s3 --> h2
        self.addLink(host1, switch3)
        self.addLink(switch3, host2)
        # h3 <-- s4 --> h4
        self.addLink(host3, switch4)
        self.addLink(switch4, host4)
        # h5 <-- s6 --> h6
        self.addLink(host5, switch6)
        self.addLink(switch6, host6)
        # h7 <-- s7 --> h8
        self.addLink(host7, switch7)
        self.addLink(switch7, host8)

topos = { 'binary_tree': ( lambda: BinaryTreeTopo() ) }

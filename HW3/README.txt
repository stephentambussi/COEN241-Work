Stephen Tambussi - COEN241 - HW3

Task 1 Questions
======================================================
1)  Output of "nodes": c0 h1 h2 h3 h4 h5 h6 h7 h8 s1 s2 s3 s4 s5 s6 s7

    Output of "net":
        h1 h1-eth0:s3-eth2
        h2 h2-eth0:s3-eth3
        h3 h3-eth0:s4-eth2
        h4 h4-eth0:s4-eth3
        h5 h5-eth0:s6-eth2
        h6 h6-eth0:s6-eth3
        h7 h7-eth0:s7-eth2
        h8 h8-eth0:s7-eth3
        s1 lo:  s1-eth1:s2-eth1 s1-eth2:s5-eth1
        s2 lo:  s2-eth1:s1-eth1 s2-eth2:s3-eth1 s2-eth3:s4-eth1
        s3 lo:  s3-eth1:s2-eth2 s3-eth2:h1-eth0 s3-eth3:h2-eth0
        s4 lo:  s4-eth1:s2-eth3 s4-eth2:h3-eth0 s4-eth3:h4-eth0
        s5 lo:  s5-eth1:s1-eth2 s5-eth2:s6-eth1 s5-eth3:s7-eth1
        s6 lo:  s6-eth1:s5-eth2 s6-eth2:h5-eth0 s6-eth3:h6-eth0
        s7 lo:  s7-eth1:s5-eth3 s7-eth2:h7-eth0 s7-eth3:h8-eth0
        c0
2)  Output of "h7 ifconfig":
        h7-eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
                inet 10.0.0.7  netmask 255.0.0.0  broadcast 10.255.255.255
                inet6 fe80::5884:18ff:fe69:2df2  prefixlen 64  scopeid 0x20<link>
                ether 5a:84:18:69:2d:f2  txqueuelen 1000  (Ethernet)
                RX packets 59  bytes 4590 (4.5 KB)
                RX errors 0  dropped 0  overruns 0  frame 0
                TX packets 10  bytes 796 (796.0 B)
                TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

        lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
                inet 127.0.0.1  netmask 255.0.0.0
                inet6 ::1  prefixlen 128  scopeid 0x10<host>
                loop  txqueuelen 1000  (Local Loopback)
                RX packets 0  bytes 0 (0.0 B)
                RX errors 0  dropped 0  overruns 0  frame 0
                TX packets 0  bytes 0 (0.0 B)
                TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Task 2 Questions
======================================================
1) launch() --> __init__() --> start_switch() --> _handle_PacketIn() --> act_like_hub() --> resend_packet()
2) 
         h1 ping h2                      h1 ping h8
         ----------                      ----------
 a)      avg=2.374ms                     avg=7.989ms
 b) min=1.692ms max=5.507ms         min=7.021ms max=14.637ms

 c) The difference is = 5.615 ms for avg. The reason for the difference in ping time is due to the distance between hosts.
    h1 --> h2 only needs to go through 1 switch (s3), while h1 --> h8 needs to go through 5 switches (s3,s2,s1,s5,s7).
3)
 a) iperf is a tool to measure the maximum achievable bandwidth on a network. In this case, it is being used to measure the TCP bandwidth between hosts in our network.
 b)     h1 --> h2                       h1 --> h8
        ---------                       ---------
   8.25 Mbits/s, 8.94 Mbits/s   2.32 Mbits/s, 2.70 Mbits/s
 c) The differenece is ~= 5.93 Mbits/s. Similar to the reason for the difference in ping time between hosts, 
    it has to do with the number of switches that a connection needs to pass through to contact the other host.
4) Each switch observes traffic. This is because act_like_hub() sends packets to all the switches in the network. To be able to observe traffic, you can add a print statement 
   in the _handle_PacketIn() function. By getting the id of the switch (self.connection.dpid), its value can be printed when that switch receives traffic. 

Task 3 Questions
======================================================
1) The MAC to Port map is established by first checking the map to see if the destination MAC already exists. If it does exist, the packet can be directly sent to the destination,
   reducing unnecessary traffic. However, if the destination MAC does not exist in the map, then the code will flood all the packets to every host to find the correct destination. 
   Once it is found, it is added to the map for future use.
2)       h1 ping h2                      h1 ping h8
         ----------                      ----------
 a)      avg=1.912ms                     avg=6.423ms
 b) min=1.677ms max=4.255ms         min=4.340ms max=12.256ms
 c) Overall, compared to task 2, the ping times are lower when using the new function (act_like_switch). The reason for this is because the controller can now get the MAC addresses 
    and send them to the appropriate destination port using the map. This is more efficient then the packet flooding from before. 
3) 
 a)     h1 --> h2                       h1 --> h8
        ---------                       ---------
   32.5 Mbits/s, 33.5 Mbits/s   3.63 Mbits/s, 4.09 Mbits/s
 b) Once again, the increase in throughput is due to the MAC learning. Through the mapping, congestion is reduced which in turn increases throughput.
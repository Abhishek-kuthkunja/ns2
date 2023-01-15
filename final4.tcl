set ns [new Simulator]
set nf [open f4.nam w]
$ns namtrace-all $nf
set nd [open f4.tr w]
$ns trace-all $nd

proc finish { } {
global ns nf nd
$ns flush-trace
close $nf
close $nd
exec nam f4.nam &
exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail
$ns duplex-link $n0 $n5 1Mb 10ms DropTail
$ns duplex-link $n0 $n6 1Mb 10ms DropTail
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns queue-limit $n0 $n6 3
$ns queue-limit $n0 $n4 2
$ns queue-limit $n0 $n5 1

set p1 [new Agent/Ping]
$ns attach-agent $n1 $p1
set p2 [new Agent/Ping]
$ns attach-agent $n2 $p2
$ns connect $p1 $p2

set p3 [new Agent/Ping]
$ns attach-agent $n3 $p3
set p4 [new Agent/Ping]
$ns attach-agent $n4 $p4
$ns connect $p3 $p4

set p5 [new Agent/Ping]
$ns attach-agent $n5 $p5
set p6 [new Agent/Ping]
$ns attach-agent $n6 $p6
$ns connect $p5 $p6

Agent/Ping instproc recv {from rtt} {
$self instvar node_
puts "rount trip time $rtt ms"
}

$ns at 0.2 "$p1 send"
$ns at 0.2 "$p2 send"
$ns at 0.2 "$p3 send"
$ns at 0.2 "$p4 send"
$ns at 0.2 "$p5 send"
$ns at 0.2 "$p6 send"
$ns at 5.0 "finish"
$ns run


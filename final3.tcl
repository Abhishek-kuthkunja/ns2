set ns [new Simulator]
set nf [open f3.nam w]
$ns namtrace-all $nf
set nd [open f3.tr w]
$ns trace-all $nd

proc finish { } {
global ns nd nf 
$ns flush-trace
close $nf
close $nd
exec nam f3.nam &
exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set sink0 [new Agent/Null]
$ns attach-agent $n3 $sink0
$ns connect $udp0 $sink0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set tcp0 [new Agent/TCP]
$ns attach-agent $n1 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n2 $sink0
$ns connect $tcp0 $sink0

set ftp [new Application/FTP]
$ftp attach-agent $tcp0

$ns at 0.5 "$cbr0 start"
$ns at 0.5 "$ftp start"
$ns at 10.5 "$ftp stop"
$ns at 10.5 "$cbr0 stop"
$ns at 11.0 "finish"
$ns run


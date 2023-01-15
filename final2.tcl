set ns [new Simulator]
set nf [open f2.nam w]
$ns namtrace-all $nf
set nd [open f2.tr w]
$ns trace-all $nd

proc finish { } {
global ns nf nd
$ns flush-trace
close $nf
close $nd
exec nam f2.nam &
exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0
$tcp0 set fid_ 1

set ftp [new Application/FTP]
$ftp attach-agent $tcp0
$ftp set type_ FTP


set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
$tcp0 set fid_ 2

set telnet [new Application/Telnet]
$telnet attach-agent $tcp1
$telnet set type_ Telnet

$ns at 0.5 "$ftp start"
$ns at 0.5 "$telnet start"
$ns at 24.5 "$ftp stop"
$ns at 24.5 "$telnet stop"
$ns at 25.0 "finish"
$ns run



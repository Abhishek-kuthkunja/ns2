BEGIN{
    tcp1=0;
    tcp2=0;
    tcp1size=0;
    tcp2size=0;
    total1=0;
    total2=0;


}
{
    event=$1;
    event1=$5;
    event2=$9;
    event3=$10;
    event4=$6;
    if(event=="r" && event1=="tcp" && event2=="0.0" && event3=="3.0")
    {
        tcp1++;
        tcp1size=event4;
    }
    if(event=="r" && event1=="tcp" && event2=="1.0" && event3=="3.1")
    {
        tcp2++;
        tcp2size=event4;
    }

}
END{
    total1=tcp1*tcp1size*8;
    total2=tcp2*tcp2size*8;
    printf("%d %d",total1/24,total2/24);
}
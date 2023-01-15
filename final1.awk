BEGIN{
    dcount=0;
}
{
    event=$1
    if(event=="d")
    {
        dcount++;
    }
    

}
END{
    printf("dropped is %d",dcount);
}
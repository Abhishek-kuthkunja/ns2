BEGIN{
drop=0;
}
{
    event=$1;
    if(event=="d")
    {
        drop++;

    }
}
END{
    printf("dropped packet are %d\n",drop);
}
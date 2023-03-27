void main()
{
    char *video_memory = 0xb8000;
    // Display an 'X' at the top-left.
    *video_memory = 'X';
}

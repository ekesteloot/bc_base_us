enum 532 "IC Data Exchange Type" implements "IC Data Exchange"
{
    Extensible = false;
    value(0; Database)
    {
        Implementation = "IC Data Exchange" = "IC Data Exchange Database";
    }
    value(1; API)
    {
        Implementation = "IC Data Exchange" = "IC Data Exchange API";
    }
}
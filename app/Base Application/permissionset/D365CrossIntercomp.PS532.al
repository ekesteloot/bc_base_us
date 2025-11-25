permissionset 532 "D365 Cross Intercomp"
{
    Access = Public;
    Assignable = true;
    Caption = 'Dynamics 365 Business Central Cross Environment Intercompany';
    Permissions =
        tabledata "Handled IC Inbox Trans." = R,
        tabledata "IC Comment Line" = RI,
        tabledata "IC Dimension" = R,
        tabledata "IC Dimension Value" = R,
        tabledata "IC Document Dimension" = RI,
        tabledata "IC G/L Account" = R,
        tabledata "IC Inbox Jnl. Line" = RI,
        tabledata "IC Inbox Purchase Line" = RI,
        tabledata "IC Inbox Purchase Header" = RI,
        tabledata "IC Inbox Sales Header" = RI,
        tabledata "IC Inbox Sales Line" = RI,
        tabledata "IC Inbox Transaction" = RI,
        tabledata "IC Inbox/Outbox Jnl. Line Dim." = RI,
        tabledata "IC Partner" = R,
        tabledata "IC Setup" = R,
        tabledata "Bank Account" = R,
        tabledata "Job Queue Entry" = RI;
}
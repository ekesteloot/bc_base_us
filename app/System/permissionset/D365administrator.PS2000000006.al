permissionset 2000000006 D365Administrator
{
    Assignable = false;
    IncludedPermissionSets = BaseSystemPermissionSet;
    Permissions = tabledata "All Profile" = RIMD,
                  tabledata "API Webhook Notification" = Rimd,
                  tabledata "API Webhook Notification Aggr" = Rimd,
                  tabledata "API Webhook Subscription" = Rimd,
                  tabledata Company = Rimd,
                  tabledata "Configuration Package File" = Rimd,
                  tabledata "Designed Query Group" = R,
                  tabledata "Designed Query Permission" = R,
                  tabledata "External Event Subscription" = RIMD,
                  tabledata "External Event Log Entry" = RIMD,
                  tabledata "External Event Notification" = RIMD,
                  tabledata "Feature Key" = RIMD,
                  tabledata "NAV App Installed App" = R,
                  tabledata Profile = RIMD,
                  tabledata "Profile Configuration Symbols" = RIMD,
                  tabledata "Published Application" = R,
                  tabledata "Tenant Profile" = RIMD,
                  tabledata "Tenant Profile Extension" = RIMD,
                  tabledata "Tenant Profile Page Metadata" = RIMD,
                  tabledata "Tenant Profile Setting" = RIMD,
                  tabledata "User Default Style Sheet" = R,
                  tabledata "User Page Metadata" = Rimd,
                  tabledata "Webhook Notification" = Rimd;
}

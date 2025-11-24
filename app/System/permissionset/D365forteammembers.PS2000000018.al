permissionset 2000000018 D365forTeamMembers
{
    Assignable = false;
    IncludedPermissionSets = BaseSystemPermissionSet;
    Permissions = tabledata "All Profile" = RIMD,
                  tabledata "API Webhook Notification" = RIMD,
                  tabledata "API Webhook Notification Aggr" = RIMD,
                  tabledata "API Webhook Subscription" = RIMD,
                  tabledata Company = RiMd,
                  tabledata "Configuration Package File" = RiMd,
                  tabledata "Designed Query Group" = RM,
                  tabledata "Designed Query Permission" = RM,
                  tabledata "External Event Subscription" = RIMD,
                  tabledata "External Event Log Entry" = RIMD,
                  tabledata "External Event Notification" = RIMD,
                  tabledata "Feature Key" = RIMD,
                  tabledata "NAV App Installed App" = Rm,
                  tabledata Profile = RIMD,
                  tabledata "Profile Configuration Symbols" = RIMD,
                  tabledata "Published Application" = Rm,
                  tabledata "Tenant Profile" = RIMD,
                  tabledata "Tenant Profile Extension" = RIMD,
                  tabledata "Tenant Profile Page Metadata" = RIMD,
                  tabledata "Tenant Profile Setting" = RIMD,
                  tabledata "User Default Style Sheet" = RM,
                  tabledata "User Page Metadata" = RIMD,
                  tabledata "Webhook Notification" = RiMd;
}

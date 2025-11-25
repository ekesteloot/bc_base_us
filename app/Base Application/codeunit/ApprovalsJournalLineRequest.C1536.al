codeunit 1536 "Approvals Journal Line Request"
{
    TableNo = "Gen. Journal Line";

    trigger OnRun()
    begin
        OnBeforeSendJournalLineApprovalRequests(Rec);
        if WorkflowManagement.CanExecuteWorkflow(Rec, WorkflowEventHandling.RunWorkflowOnSendGeneralJournalLineForApprovalCode()) and
            not ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId)
        then
            ApprovalsMgmt.OnSendGeneralJournalLineForApproval(Rec);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSendJournalLineApprovalRequests(var GenJournalLine: Record "Gen. Journal Line")
    begin
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
}
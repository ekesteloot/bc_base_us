// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

namespace System.Agents.TaskPane;

using System.Security.AccessControl;
using System.Agents;

page 2000000100 "Agent Tasks"
{
    PageType = ListPlus;
    ApplicationArea = All;
    SourceTable = "Agent Task Timeline";
    Caption = 'Agent Tasks';
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    Extensible = false;
    SourceTableView = sorting("Last Step Timestamp") order(descending);
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(Content)
        {
            repeater(AgentTasks)
            {
                Editable = false;
                field(TaskId; Rec."Task ID")
                {
                }
                field(TaskNeedsAttention; Rec."Needs Attention")
                {
                }
                field(TaskIndicator; Rec.Indicator)
                {
                }
                field(TaskStatus; Rec.Status)
                {
                }
                field(TaskHeader; Rec.Title)
                {
                    Caption = 'Header';
                    ToolTip = 'Specifies the header of the task.';
                }
                field(TaskSummary; TaskSummary)
                {
                    Caption = 'Summary';
                    ToolTip = 'Specifies the summary of the task.';
                }
                field(TaskStartedOn; Rec.SystemCreatedAt)
                {
                    Caption = 'Started On';
                    ToolTip = 'Specifies the date and time when the task was started.';
                }
                field(TaskCreatedBy; GlobalCreatedBy)
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the user who created the task.';
                }
                field(TaskLastStepCompletedOn; Rec."Last Step Timestamp")
                {
                    Caption = 'Last Step Completed On';
                    ToolTip = 'Specifies the date and time when the last step for the task was completed.';
                }
                field(TaskStepType; Rec."Current Step Type")
                {
                    Caption = 'Step Type';
                    ToolTip = 'Specifies the type of the last step.';
                }
                field(TaskPrimaryTimelineStepCount; Rec."Primary Timeline Step Count")
                {
                    Caption = 'Primary Timeline Step Count';
                    ToolTip = 'Specifies the count of primary timeline steps.';
                }
                field(TaskSecondaryTimelineStepCount; Rec."Secondary Timeline Step Count")
                {
                    Caption = 'Secondary Timeline Step Count';
                    ToolTip = 'Specifies the count of secondary timeline steps.';
                }
            }
        }

        area(FactBoxes)
        {
            part(Timeline; "Agent Task Timeline")
            {
                SubPageLink = "Task ID" = field("Task ID");
                UpdatePropagation = Both;
                Editable = true;
            }

            part(Details; "Agent Task Details")
            {
                Provider = Timeline;
                SubPageLink = "Task ID" = field("Task ID"), "Timeline Step ID" = field(ID);
                Editable = true;
            }
        }
    }
    actions
    {
        area(Processing)
        {
#pragma warning disable AW0005
            action(StopTask)
#pragma warning restore AW0005
            {
                Caption = 'Stop task';
                ToolTip = 'Stops the task.';
                Scope = Repeater;
                trigger OnAction()
                var
                    AgentTaskRecord: Record "Agent Task";
                begin
                    AgentTaskRecord.Get(Rec."Task ID");
                    AgentTask.StopTask(AgentTaskRecord, AgentTaskRecord."Status"::"Stopped by User", false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetTaskDetails();
    end;

    local procedure SetTaskDetails()
    var
        User: Record "User";
        InStream: InStream;
    begin
        // Clear old values
        Clear(TaskSummary);
        GlobalCreatedBy := '';

        Rec.CalcFields("Summary");
        if Rec."Summary".HasValue() then begin
            Rec."Summary".CreateInStream(InStream, AgentTask.GetDefaultEncoding());
            TaskSummary.Read(InStream);
        end;

        User.SetRange("User Security ID", Rec."Created By");
        if User.FindFirst() then
            if User."Full Name" <> '' then
                GlobalCreatedBy := User."Full Name"
            else
                GlobalCreatedBy := User."User Name";
    end;

    var
        AgentTask: Codeunit "Agent Task Internal";
        TaskSummary: BigText;
        GlobalCreatedBy: Text[250];
}
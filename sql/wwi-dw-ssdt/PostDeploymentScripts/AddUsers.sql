if user_id('ETLUser') is null 
begin
    create user ETLUser with password = '$(ETLUserPassword)';
    alter role db_owner add member ETLUser
end
go

if user_id('AppUser') is null 
begin
    create user AppUser with password = '$(AppUserPassword)';
end
go

MERGE INTO [Dimension].[Employee] AS [Target]
USING (VALUES
(0,0,N'Unknown',N'N/A',0,NULL,'2013-01-01T00:00:00','9999-12-31T23:59:59.9999999',0)
,(1,14,N'Lily Code',N'Lily',1,NULL,'2013-01-01T00:00:00','2013-01-01T08:00:00',3)
,(2,4,N'Isabella Rupp',N'Isabella',0,NULL,'2013-01-01T00:00:00','2013-01-01T08:00:00',3)
,(3,11,N'Ethan Onslow',N'Ethan',0,NULL,'2013-01-01T00:00:00','2013-01-04T08:00:00',3)
,(4,7,N'Amy Trefl',N'Amy',1,NULL,'2013-01-01T00:00:00','2013-01-05T08:00:00',3)
,(5,19,N'Jai Shand',N'Jai',0,NULL,'2013-01-01T00:00:00','2013-01-06T08:00:00',3)
,(6,8,N'Anthony Grosse',N'Anthony',1,NULL,'2013-01-01T00:00:00','2013-01-09T08:00:00',3)
,(7,15,N'Taj Shand',N'Taj',1,NULL,'2013-01-01T00:00:00','2013-01-11T08:00:00',3)
,(8,13,N'Hudson Hollinworth',N'Hudson',1,NULL,'2013-01-01T00:00:00','2013-01-11T08:00:00',3)
,(9,20,N'Jack Potter',N'Jack',1,NULL,'2013-01-01T00:00:00','2013-01-14T08:00:00',3)
,(10,17,N'Piper Koch',N'Piper',0,NULL,'2013-01-01T00:00:00','2013-01-19T08:00:00',3)
) AS [Source] ([Employee Key],[WWI Employee ID],[Employee],[Preferred Name],[Is Salesperson],[Photo],[Valid From],[Valid To],[Lineage Key])
ON ([Target].[Employee Key] = [Source].[Employee Key])
WHEN NOT MATCHED BY TARGET THEN
INSERT([Employee Key],[WWI Employee ID],[Employee],[Preferred Name],[Is Salesperson],[Photo],[Valid From],[Valid To],[Lineage Key])
VALUES([Source].[Employee Key],[Source].[WWI Employee ID],[Source].[Employee],[Source].[Preferred Name],[Source].[Is Salesperson],[Source].[Photo],[Source].[Valid From],[Source].[Valid To],[Source].[Lineage Key]);
go
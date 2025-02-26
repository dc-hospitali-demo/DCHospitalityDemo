public class ObjectAndFieldLevelPermission {
    
    public static void insertObjectLevelPermission(List<String> objectNames) {
        if (objectNames.isEmpty()) {
            System.debug('## Error: No objects provided.');
            return;
        }
        // Fetch the permission set
        PermissionSet permissionSet;
        try {
            permissionSet = [SELECT Id FROM PermissionSet WHERE Label = 'Data Cloud Salesforce Connector' LIMIT 1];
        } catch (Exception e) {
            System.debug('## Error fetching PermissionSet: ' + e.getMessage());
            return;
        }
        if (permissionSet == null) {
            System.debug('## Error: PermissionSet not found.');
            return;
        }
        System.debug('## PermissionSet found: ' + permissionSet.Id);
        // Fetch existing object permissions
        Set<String> existingObjectPermissions = new Set<String>();
        for (ObjectPermissions op : [
            SELECT SObjectType FROM ObjectPermissions 
            WHERE ParentId = :permissionSet.Id AND SObjectType IN :objectNames
        ]) {
            existingObjectPermissions.add(op.SObjectType);
        }
        // Prepare new permissions only for missing objects
        List<ObjectPermissions> newPermissions = new List<ObjectPermissions>();
        for (String obj : objectNames) {
            if (!existingObjectPermissions.contains(obj)) {
                ObjectPermissions objectPM = new ObjectPermissions();
                objectPM.ParentId = permissionSet.Id;
                objectPM.SObjectType = obj;
                objectPM.PermissionsRead = true;
                objectPM.PermissionsViewAllRecords = true;
                newPermissions.add(objectPM);
            } else {
                System.debug('## Skipping: Permission already exists for ' + obj);
            }
        }
        // Insert only if there are new permissions to add
        if (!newPermissions.isEmpty()) {
            try {
                insert newPermissions;
                System.debug('## Inserted new object permissions: ' + newPermissions);
            } catch (Exception e) {
                System.debug('## Error inserting ObjectPermissions: ' + e.getMessage());
            }
        } else {
            System.debug('## No new permissions needed.');
        }
    }
    
    public static void insertFieldLevelPermsssion(String permissionSetName, String objectName, List<String> fieldNames){
        PermissionSet permissionSetId = [Select Id from PermissionSet Where Label = 'Data Cloud Salesforce Connector' Limit 1];
        System.debug('## permissionSetId = '+permissionSetId);
        List<FieldPermissions> listOfFieldPermissions = new List<FieldPermissions>();
        for (String field : fieldNames) {
            FieldPermissions fieldPermission = new FieldPermissions();
            fieldPermission.Field = objectName + '.' + field;
            fieldPermission.SobjectType = objectName;
            fieldPermission.ParentId = permissionSetId.Id;
            fieldPermission.PermissionsEdit = false;
            fieldPermission.PermissionsRead = true;
            listOfFieldPermissions.add(fieldPermission);
        }
        if(!listOfFieldPermissions.isEmpty()){
            upsert listOfFieldPermissions;
            System.debug('## listOfFieldPermissions = '+listOfFieldPermissions);
        }
    }
    //Automation For Loyalty Tier
    public static void assignPermissionSetForLoyalty(){
        String permissionSetName = 'sfdc_a360_sfcrm_data_extract';
        // Fetch the Permission Set ID
        PermissionSet permSet = [SELECT Id FROM PermissionSet WHERE Name = :permissionSetName LIMIT 1];
        system.debug('permSet'+permSet);
        if (permSet == null) {
            System.debug('Permission Set not found: ' + permissionSetName);
            return;
        }
        // List of Objects (Modify as needed)
        List<String> objectNames = new List<String>{
            'LoyaltyLedger','LoyaltyMemberCurrency','LoyaltyMemberCurrency','LoyaltyMemberTier','ProductCatalog','ProductCategory','LoyaltyPartnerProduct',
                'LoyaltyProgramCurrency','LoyaltyProgramMemberCase','LoyaltyProgramMbrPromotion','LoyaltyProgramMember','LoyaltyProgramPartner','LoyaltyProgram',
                'LoyaltyTierBenefit','LoyaltyTierGroup','LoyaltyTier','MemberBenefit','PromotionLoyaltyPtnrProdt','PromotionMarketSegment','Promotion','TransactionJournal',
                'Voucher','VoucherDefinition','JournalSubType','JournalType','Campaign','BenefitType','Benefit','LoyaltyAggrPointExprLedger','LoyaltyPgmEngmtAttrProm','LoyaltyPgmEngmtAttribute',
                'LoyaltyPgmGroupMbrRlnsp','LoyaltyPgmMbrAttributeVal','LoyaltyPgmPartnerPromotion','LoyaltyProgramBadge','LoyaltyProgramMemberBadge','Segments','UnitOfMeasure'
                };
                    system.debug('Object Name'+objectNames);
        // Fetch existing permissions for these objects under this Permission Set
        Map<String, ObjectPermissions> existingPerms = new Map<String, ObjectPermissions>();
        for (ObjectPermissions op : [SELECT Id, SObjectType 
                                     FROM ObjectPermissions 
                                     WHERE ParentId = :permSet.Id 
                                     AND SObjectType IN :objectNames]) {
                                         existingPerms.put(op.SObjectType, op);
                                     }
        // Prepare ObjectPermissions records to insert
        List<ObjectPermissions> objPermsToInsert = new List<ObjectPermissions>();
        for (String objectName : objectNames) {
            if (!existingPerms.containsKey(objectName)) {
                ObjectPermissions objPerm = new ObjectPermissions(
                    ParentId = permSet.Id,
                    SObjectType = objectName,
                    PermissionsRead = true,
                    PermissionsViewAllRecords = true
                );
                System.debug('Object to insert'+objPerm);
                objPermsToInsert.add(objPerm);
            } else {
                System.debug('Skipping ' + objectName + ' - Permission already exists.');
            }
        }
        // Insert only new permissions
        if (!objPermsToInsert.isEmpty()) {
            try {
                insert objPermsToInsert;
                System.debug('Object Permissions Assigned Successfully!');
            } catch (Exception e) {
                System.debug('Error Assigning Permissions: ' + e.getMessage());
            }
        } else {
            System.debug('No new permissions needed - Everything is already assigned.');
        }
        
    }
    
    //Automation for Create an AgentUser
    public static void botUserForServiceAgent(){
        //to create Agent User
        String emailAddress = UserInfo.getUserEmail();
        String userName = emailAddress +'.'+'sunshineresortserviceagent';
        
        UserLicense ul=[SELECT Id, Status, MasterLabel, Name FROM UserLicense Where Name='Einstein Agent' LIMIT 1];
        Profile prof = [SELECT Id, UserLicenseId FROM Profile WHERE Name='Einstein Agent User' AND UserLicenseId =: ul.Id limit 1];
        if(prof !=null){
            User usr = new user();
            usr.FirstName = 'Agent';
            usr.LastName='User';
            usr.Email = emailAddress;
            usr.Alias = 'agtuser';
            usr.Username = userName;
            usr.LocaleSidKey = 'en_US';
            usr.TimeZoneSidKey = 'GMT';
            usr.ProfileID = prof.id;
            usr.LanguageLocaleKey = 'en_US';
            usr.EmailEncodingKey = 'UTF-8';
            insert usr;
        }
        User agentUser = [SELECT Id FROM User WHERE FirstName='Agent' AND LastName ='User' LIMIT 1];
        //Assign 'Agentforce Service Agent User' Permission Set License to Agent User
        PermissionSet permSet = [SELECT Id,Name FROM PermissionSet Where Name ='AgentforceServiceAgentUser'];
        PermissionSetLicense pslicense= [SELECT DeveloperName,Id,MasterLabel FROM PermissionSetLicense Where MasterLabel ='Agentforce Service Agent User' LIMIT 1];
        if(pslicense !=null){
            PermissionSetLicenseAssign pslicnseAssignee = New PermissionSetLicenseAssign();
            pslicnseAssignee.AssigneeId=agentUser.Id;
            pslicnseAssignee.PermissionSetLicenseId =pslicense.Id;
            Insert pslicnseAssignee;
        }
        if(permSet !=null){
            PermissionSetAssignment permissionSetAssignment = new PermissionSetAssignment();
            permissionSetAssignment.PermissionSetId = permSet.Id;
            permissionSetAssignment.AssigneeId = agentUser.Id;
            
            insert permissionSetAssignment;
        }
    }
    
    //Automation for creating Custom Fields
    public static void createCustomFields(){
        Boolean alreadyPresent=false;
        String objectAPIName='Contact';
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectAPIName).getDescribe().fields.getMap();
        for(String fieldName : fieldMap.keyset() )
        { 
            if(fieldName =='External_Id__c'){
                system.debug('fieldName->>'+fieldName); // This will give you the api name of the field name.
                alreadyPresent=true;
                break;
            }
            
        }
        //to create Custom Field
        System.debug('break executed'+alreadyPresent);
        
        if(alreadyPresent!=false){
            System.debug('present'+alreadyPresent);
        }
        else{
            System.debug('not present'+alreadyPresent);
            String fieldAPIName='External_Id__c';
            String fieldDescription=''; 
            String fieldLabel='External Id';
            String metadata = '{"Metadata" : {"type" : "Text","description" : "'+fieldDescription+'", "inlineHelpText" : "","precision" : null,"label" : "'+fieldLabel+'","length" : 255,"required" : false}, "FullName" : "'+objectAPIName+'.'+fieldAPIName+'"}';
            
            HttpRequest request = new HttpRequest();
            request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
            request.setHeader('Content-Type', 'application/json');
            request.setEndpoint(URL.getOrgDomainUrl().toExternalForm()+'/services/data/v62.0/tooling/sobjects/CustomField');
            request.setMethod('POST');
            request.setBody(metadata);
            Http http = new Http();
            HTTPResponse res = http.send(request);
            //return res.getBody();
        }
    }
    
    //Automation for assigning Permission Set to Integration User
    public static void assignIntegrationPermSet(){
        String permissionSetName='sfdc_a360';
        PermissionSet permSet = [SELECT Id FROM PermissionSet WHERE Name = :permissionSetName LIMIT 1];
        System.debug('Permission Set After Query ' + permSet);
        if (permSet == null) {
            System.debug('Permission Set not found: ' + permissionSetName);
            return;
        }
        String objectName = 'Contact';
        List<ObjectPermissions> existingPerm = [SELECT Id, SObjectType 
                                                FROM ObjectPermissions 
                                                WHERE ParentId = :permSet.Id 
                                                AND SObjectType= :objectName LIMIT 1 ];
        System.debug('Existing Permission Set Check'+existingPerm);
        if(existingPerm!=null){
            System.debug('Contact Permissions already exist-Skipping');
            return;
        }
        ObjectPermissions contactPerm = new ObjectPermissions(
            ParentId = permSet.Id,
            SObjectType = objectName,
            PermissionsDelete = true,
            PermissionsModifyAllRecords = true
        );
        try{
            insert contactPerm;
            system.debug('Contact object Permission Set Assigned Successfully');
        }catch(Exception e){
            System.debug('Error Assigning Permissions'+e.getMessage());
        }
    }
}
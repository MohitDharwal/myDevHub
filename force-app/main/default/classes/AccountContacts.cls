public with sharing class AccountContacts 
{  
    @AuraEnabled
    public static List<Account> getAccount()
    {
        List<Account> accountList = new List<Account>();
        accountList = [Select If45t5rfrd,Name,Phone from Account];
        return accountList;
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts()
    {
        List<Account> accountList = new List<Account>();
        accountList = [Select Id,Name,Phone from Account];
        return accountList;
    }
    @AuraEnabled
    public static List<Contact> contactAccounts(String accId)
    {
        System.debug('Account Id :'+accId);
        List<Contact> conList = new List<Contact>();
        System.debug('Contact List Before :'+conList);
        conList =  [Select Id,Name,Phone,Email,AccountId,Account.Name from Contact where AccountId =: accId]; 
        System.debug('Contact List After :'+conList);
        return conList;
    }
    @AuraEnabled
    public static List<Contact> getRelatedContacts(List<String> accId)
    {
        System.debug('Lol :'+accId);
        // System.debug('Ids :'+idset);
        // idset.add(accId);
        // System.debug('Set Of Ids :'+idset);
        List<Contact> conList = [Select Id,Name,Phone,Email,AccountId,Account.Name from Contact where AccountId In:accId];
        return conList;
    }
    @AuraEnabled
    public static string updateAccounts(Object data) 
    {
        System.debug('Data:'+data);
        List<Account> accList = new List<Account>();
        List<Account> accountsForUpdate = (List<Account>) JSON.deserialize(JSON.serialize(data),List<Account>.class);
        try 
        {
            for(Account acc:accountsForUpdate)
            {
                Account acNew = new Account();
                acNew.Id = acc.Id;
                acNew.Phone = acc.Phone;
                acNew.Name = acc.Name;
                accList.add(acNew);
            }
            update accList;
            return 'Success: Accounts updated successfully';
        }
        catch (Exception e) 
        {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
    @AuraEnabled
    public static string updateContacts(Object data)
    {
        System.debug('New Data :'+data);
        List<Contact> conList = new List<Contact>();
        List<Contact>contactForUpdate = (List<Contact>) JSON.deserialize(JSON.serialize(data),List<Contact>.class);
        try 
        {
            for(Contact con:contactForUpdate)
            {
                Contact conNew = new Contact();
                conNew.Id = con.Id;
                conNew.Email = con.Email;
                conNew.FirstName = con.FirstName;
                conNew.LastName = con.LastName;
                conList.add(conNew);
            }
            System.debug('Contact List :'+conList);
            update conList;
            return 'Success: Contact updated successfully';
        }
        catch (Exception e) 
        {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
    @AuraEnabled
    public static List<Account> updateAccountList(List<Account> accList)
    {
        System.debug(accList);
        update accList;
        return accList;
    }
}
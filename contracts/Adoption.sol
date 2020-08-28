pragma solidity ^0.4.17;

/**
Contract that will handle the registrations of participants in a conference.
*/
contract Adoption {
    mapping(address => uint) registrants;
    mapping(uint => uint) numRegistrants;

    /**
    @notice function that will subscribe the contract to an event if not exceed the quota.
    @param eventId the ID of the given event.
    @param eventQuota the maximum number that can be registered.
    */
    function subscribe(uint eventId, uint eventQuota) public payable returns (uint) {
          require(numRegistrants[eventId] <= eventQuota);
          registrants[msg.sender] = eventId;
          numRegistrants[eventId] += 1;
          return registrants[msg.sender];
    }

    /**
    @notice function that will unsubscribe the contract from the event.
    @param eventId id of the event.
    */
    function unscribe(uint eventId) public payable returns (uint){
        require(registrants[msg.sender] == eventId);
        registrants[msg.sender] = 0;
        numRegistrants[eventId] -= 1;
        return registrants[msg.sender];
    }

   /**
   @notice function that return the id of the event that the contract is subscribed.
   @return the id of the event.
   */
    function getEventId() public view returns (uint) {
        return registrants[msg.sender];
    }

    /**
    @notice function that will transfer a event ticket to the given address.
    @param addressTrans the address to transfer the ticket.
    @return the ticket id.
    */
    function transferSubscription(address addressTrans) public payable returns (uint) {
        require(registrants[msg.sender] != 0 && registrants[addressTrans] == 0);
        registrants[addressTrans] = registrants[msg.sender];
        registrants[msg.sender] = 0;
        return registrants[addressTrans];
    }
}

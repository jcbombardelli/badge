pragma solidity ^0.5.9;

contract TheBadge {

    address payable public owner;

    struct Issuer {

        string name;
        string url;
        string organization;
        address addr;

    }

    struct Badge {

        uint id;
        string name;
        string description;
        string awardee;
        string assertion;
        string criteria;
        string image;
        uint registeredAt;

    }

    Issuer[] private issuers;
    Badge[] private badges;

    mapping(address => Badge[]) badgesByAddressAwardee;
    mapping(address => bool) issuersAuthorized;
    mapping(uint => uint) indexedPositionIssuersById;


    /*Events*/
    event NewBadgeIssued(address to, uint id, string name);


    constructor () public{
        owner = msg.sender;
    }


    modifier onlyOwner() {
        require(owner == msg.sender, 'only owner can execute this operation');
        _;
    }

    modifier exceptOwner() {
        require(owner != msg.sender, 'owner not execute this operation');
        _;
    }

    //modifier isNotOwner


    function newIssuer(string memory _name, string memory _url, string memory _organization, address _address) onlyOwner() public {

        Issuer memory nIssuer = Issuer({
            name: _name,
            url: _url,
            organization: _organization,
            addr: _address
        });

        issuers.push(nIssuer);
    }

    function revokeIssuer(address _addr) public onlyOwner() {


    }

    function newBadge(address _to, string memory _name, string memory _description,
        string memory _awardee, string memory _assertion, string memory _criteria, string memory _image) public exceptOwner() {


        uint _now = now;
        uint _id = generateBadgeId(_name, _description, _awardee, _assertion, _criteria, _now);

        Badge memory badge = Badge({
            id: _id,
            name: _name,
            description: _description,
            awardee: _awardee,
            assertion: _assertion,
            criteria: _criteria,
            image: _image,
            registeredAt: _now
        });

        badges.push(badge);
        badgesByAddressAwardee[_to];


        emit NewBadgeIssued(_to, badge.id, badge.name);

    }

    function revokeBadge(){
        
    }

    /*Utils*/
    function generateBadgeId(string memory _name, string memory _description, string memory _awardee,
        string memory _assertion, string memory _criteria, uint _timeRegister) public pure returns(uint) {

        return uint(keccak256(abi.encodePacked(_name, _description, _awardee, _assertion, _criteria, _timeRegister)));
    }
}
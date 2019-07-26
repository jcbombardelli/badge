pragma solidity ^0.5.9;
pragma experimental ABIEncoderV2;

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
        address awardee;
        string assertion;
        string criteria;
        string image;
        uint registeredAt;

    }

    Issuer[] private issuers;
    Badge[] private badges;

    mapping(address => uint) indexedPositionIssuersByAddress;
    mapping(address => uint[]) indexedPositionBadgesByAddress;

    /*Events*/
    event NewBadgeIssued(address to, uint id, string name);
    event NewIssuerCreated(address issuer);


    constructor () public{
        owner = msg.sender;
        indexedPositionIssuersByAddress[address(0x0)] = 0;
        issuers.push(Issuer({ name: "", url: "", organization: "",
            addr: address(0x0)}));

        indexedPositionIssuersByAddress[address(0x0)] = 0;
        badges.push(Badge({ id: 0, name: "", description: "",
            awardee: address(0x0), assertion: "",
            criteria: "", image: "", registeredAt: 0 }));

    }

    modifier onlyOwner() {
        require(owner == msg.sender, 'only owner can execute this operation');
        _;
    }

    modifier onlyIssuer() {
        require(isIssuer(msg.sender), 'only issuer can execute this operation');
        _;
    }

    function newIssuer(
        string memory _name, string memory _url, string memory _organization, address _address) public onlyOwner {

        Issuer memory nIssuer = Issuer({
            name: _name,
            url: _url,
            organization: _organization,
            addr: _address
        });

        issuers.push(nIssuer);
        emit NewIssuerCreated(nIssuer.addr);

    }

    function revokeIssuer(address _addr) public onlyOwner {

        uint indexIssuer = indexedPositionIssuersByAddress[_addr];
        require(indexIssuer > 0, "Issuer no exists");

        uint lastIndexIssuer = issuers.length - 1;
        issuers[indexIssuer] = issuers[lastIndexIssuer];

        delete indexedPositionIssuersByAddress[_addr];
        indexedPositionIssuersByAddress[issuers[lastIndexIssuer].addr] = indexIssuer;

    }

    function isIssuer(address _addr) public view returns(bool){
        return indexedPositionIssuersByAddress[_addr] > 0;
    }


    function newBadge(address _to, string memory _name, string memory _description,
        address _awardee, string memory _assertion, string memory _criteria, string memory _image) public onlyIssuer {

        require(indexedPositionIssuersByAddress[_to] == 0, "Issuer cant receiver the badge");

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

        emit NewBadgeIssued(_to, badge.id, badge.name);

    }

     function countBadgesByAddress(address _addr) public view returns(uint){
        uint[] memory indexes = indexedPositionBadgesByAddress[_addr];
        return indexes.length;
    }

    function listBadgesByAddress(address _addr) public view
        returns(uint[] memory, string[] memory, string[] memory, string[] memory, string[] memory, string[] memory){

        uint[] memory indexes = indexedPositionBadgesByAddress[_addr];

        uint[] memory ids = new uint[](indexes.length);
        string[] memory names = new string[](indexes.length);
        string[] memory descriptions = new string[](indexes.length);
        string[] memory assertions = new string[](indexes.length);
        string[] memory criterias = new string[](indexes.length);
        string[] memory images = new string[](indexes.length);

        for(uint index = 0; index < indexes.length; index++) {
            ids[index] = badges[indexes[index]].id;
            names[index] = badges[indexes[index]].name;
            descriptions[index] = badges[indexes[index]].description;
            assertions[index] = badges[indexes[index]].assertion;
            criterias[index] = badges[indexes[index]].criteria;
            images[index] = badges[indexes[index]].image;
        }

        return (ids, names, descriptions, assertions, criterias, images);
    }


    /*Utils*/
    function generateBadgeId(string memory _name, string memory _description, address _awardee,
        string memory _assertion, string memory _criteria, uint _timeRegister) public pure returns(uint) {

        return uint(keccak256(abi.encodePacked(_name, _description, _awardee, _assertion, _criteria, _timeRegister)));
    }
}
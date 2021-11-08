pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

    struct purchase {
        uint32 id;
        string name;
        uint32 number;
        uint64 createdAt;
        bool isBought;
        uint32 priceForAll;
    }
    struct shoppingSummary {
        uint32 paidCount;
        uint32 unpaidCount;
        uint32 sum;
    }

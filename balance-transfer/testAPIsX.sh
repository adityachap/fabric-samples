func (t *SimpleChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response  {
        logger.Info("########### example_cc0 Init ###########")

        _, args := stub.GetFunctionAndParameters()

        var key string    // Entities
        var val, i int // Asset holdings
        var err error

        if (len(args)%2) != 0 {
                return shim.Error("Please input even number of arguments as [key & value]")
        }


        for i=0;i<len(args);i=i+2 {
          key = args[i]
          val, err = strconv.Atoi(args[i+1])

          if err != nil {
            return shim.Error("Expecting integer value for asset holding")
          }

          logger.Info("key = %d, val = %d\n", key, val)

          err = stub.PutState(key, []byte(strconv.Itoa(val)))
          if err != nil {
             return shim.Error(err.Error())
          }

        }

        return shim.Success(nil)
}

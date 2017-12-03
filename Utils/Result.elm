module Utils.Result exposing (traverse)


traverse : (a -> Result err b) -> List a -> Result err (List b)
traverse fn =
    let
        step a result =
            case fn a of
                Ok b ->
                    Result.map ((::) b) result

                Err err ->
                    Err err
    in
    List.foldr step (Ok [])

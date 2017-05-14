module TrebleClef exposing (trebleClef, baseClef)

import Svg as S exposing (..)
import Svg.Attributes exposing (..)
import Actions exposing (..)

trebleClef : List (Svg Msg)
trebleClef =
    [ S.path
        [ transform "scale(0.6)"
        , d "M25.5 49c0.305 3.1263-2.019 5.6563-4.0772 7.7014-0.9349 0.897-0.155 0.148-0.6437 0.594-0.1022-0.479-0.2986-1.731-0.2802-2.11 0.1304-2.6939 2.3198-6.5875 4.2381-8.0236 0.309 0.5767 0.563 0.6231 0.763 1.8382zm0.651 16.142c-1.232-0.906-2.85-1.144-4.3336-0.885-0.1913-1.255-0.3827-2.51-0.574-3.764 2.3506-2.329 4.9066-5.0322 5.0406-8.5394 0.059-2.232-0.276-4.6714-1.678-6.4836-1.7004 0.12823-2.8995 2.156-3.8019 3.4165-1.4889 2.6705-1.1414 5.9169-0.57 8.7965-0.8094 0.952-1.9296 1.743-2.7274 2.734-2.3561 2.308-4.4085 5.43-4.0046 8.878 0.18332 3.334 2.5894 6.434 5.8702 7.227 1.2457 0.315 2.5639 0.346 3.8241 0.099 0.2199 2.25 1.0266 4.629 0.0925 6.813-0.7007 1.598-2.7875 3.004-4.3325 2.192-0.5994-0.316-0.1137-0.051-0.478-0.252 1.0698-0.257 1.9996-1.036 2.26-1.565 0.8378-1.464-0.3998-3.639-2.1554-3.358-2.262 0.046-3.1904 3.14-1.7356 4.685 1.3468 1.52 3.833 1.312 5.4301 0.318 1.8125-1.18 2.0395-3.544 1.8325-5.562-0.07-0.678-0.403-2.67-0.444-3.387 0.697-0.249 0.209-0.059 1.193-0.449 2.66-1.053 4.357-4.259 3.594-7.122-0.318-1.469-1.044-2.914-2.302-3.792zm0.561 5.757c0.214 1.991-1.053 4.321-3.079 4.96-0.136-0.795-0.172-1.011-0.2626-1.475-0.4822-2.46-0.744-4.987-1.116-7.481 1.6246-0.168 3.4576 0.543 4.0226 2.184 0.244 0.577 0.343 1.197 0.435 1.812zm-5.1486 5.196c-2.5441 0.141-4.9995-1.595-5.6343-4.081-0.749-2.153-0.5283-4.63 0.8207-6.504 1.1151-1.702 2.6065-3.105 4.0286-4.543 0.183 1.127 0.366 2.254 0.549 3.382-2.9906 0.782-5.0046 4.725-3.215 7.451 0.5324 0.764 1.9765 2.223 2.7655 1.634-1.102-0.683-2.0033-1.859-1.8095-3.227-0.0821-1.282 1.3699-2.911 2.6513-3.198 0.4384 2.869 0.9413 6.073 1.3797 8.943-0.5054 0.1-1.0211 0.143-1.536 0.143z" ]
        [] ]

baseClef : List (Svg Msg)
baseClef =
    [ g
        [ transform "translate(5.7,53.2), scale(0.15)" ]
        [ S.path
            [ d "M10.332,95c0.46-0.827,1.272-1.173,2.078-1.539     c4.8-2.188,9.741-4.08,14.325-6.72c8.059-4.639,15.17-10.369,20.606-18.017c4.833-6.8,7.699-14.3,8.348-22.656     c0.592-7.635,0.188-15.176-1.76-22.599c-0.841-3.201-2.213-6.158-4.329-8.746c-3.538-4.328-8.21-5.795-13.583-5.275     c-4.443,0.43-8.435,2.068-11.842,5.022c-2.297,1.992-3.724,4.463-4.143,7.484c-0.057,0.409-0.27,0.977,0.155,1.223     c0.383,0.223,0.685-0.29,0.997-0.504c2.789-1.911,5.748-3.217,9.222-2.363c4.063,1,6.773,3.436,7.794,7.593     c0.631,2.57,0.662,5.129,0.022,7.706c-1.74,7.007-8.102,8.873-13.083,8.23c-5.892-0.76-8.861-4.622-10.281-9.997     C12.104,23.42,17.206,12.841,27.316,7.827c2.761-1.369,5.712-2.01,8.695-2.586c2.64,0,5.28,0,7.92,0     c2.873,0.5,5.75,0.985,8.487,2.044c6.413,2.481,10.806,7.079,13.832,13.14c2.128,4.262,3.086,8.822,3.378,13.515     c0.412,6.633-0.117,13.174-2.398,19.497c-2.996,8.304-7.887,15.3-14.417,21.2C42.67,83.803,30.792,89.897,17.997,94.378     c-1.471,0.515-2.962,0.974-4.416,1.531c-1.189,0.456-2.259,0.426-3.249-0.429C10.332,95.32,10.332,95.16,10.332,95z" ]
            []
        , S.path
            [ d "M77.208,19.527c0-3.447,2.512-5.966,5.955-5.973     c3.488-0.007,6.054,2.52,6.103,6.01c0.046,3.344-2.747,6.091-6.137,6.037C79.727,25.545,77.208,22.962,77.208,19.527z" ]
            []
        , S.path
            [ d "M83.211,52.127c-3.456,0.002-5.987-2.504-6.003-5.943     c-0.016-3.429,2.528-6.059,5.908-6.106c3.311-0.046,6.149,2.774,6.141,6.099C89.248,49.565,86.647,52.125,83.211,52.127z" ]
            []
        ]
    ]


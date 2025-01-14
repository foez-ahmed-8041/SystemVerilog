# addr_decoder (module)

### Author : Foez Ahmed (foez.official@gmail.com)

## TOP IO
<img src="./addr_decoder_top.svg">

## Description

The `addr_decoder` module is a parameterized SystemVerilog module that decodes an input address to
select a slave device. The module uses a priority encoder and a multiplexer to select the
appropriate slave based on the input address.

## Parameters
|Name|Type|Dimension|Default Value|Description|
|-|-|-|-|-|
|ADDR_WIDTH|int||common_default_param_pkg::ADDR_DECODER_ADDR_WIDTH| width of the address input|
|SLV_INDEX_WIDTH|int||common_default_param_pkg::ADDR_DECODER_SLV_INDEX_WIDTH| width of the slave index|
|NUM_RULES|int||common_default_param_pkg::ADDR_DECODER_NUM_RULES| number of address map rules|
|addr_map_t|type||common_default_param_pkg::addr_decoder_addr_map_t| type of the address map|
|ADDR_MAP|addr_map_t|[NUM_RULES]|common_default_param_pkg::ADDR_MAP| address map array|

## Ports
|Name|Direction|Type|Dimension|Description|
|-|-|-|-|-|
|addr_i|input|logic [ADDR_WIDTH-1:0]|| input address|
|slave_index_o|output|logic [SLV_INDEX_WIDTH-1:0]|| output slave index|
|addr_found_o|output|logic|| A logic output that indicates if the address was found in the address map|

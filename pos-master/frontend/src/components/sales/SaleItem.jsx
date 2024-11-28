import React from "react";

const SaleItems = (props) => {
  const { product, onAdd } = props;
  //console.log(product)

  return (

    <div
      className="row-span-1 -mt-[3px] cursor-pointer overflow-hidden rounded-sm shadow-lg p-[1px] whitespace-nowrap z-40"
      onClick={() => onAdd(product)}
    >
        {/* <span className="pt-[3px] text-base font-medium text-[red]">
          {product.product_id}
        </span> */}
        <span className="pt-[3px] text-left font-medium text-blue-500">
          បរិមាណ({product.qty}) 
        </span>
      <img
        //src={`http://localhost:3001/${product.product_image}`}
        src={product.product_image}
        alt="img"
        className="rounded-sm h-[111px] w-[200px] hover:scale-105 duration-300 transition-all ease-in-out z-0"
      />
      <div className="bg-[#fff] flex-col items-start p-[2px] shadow-sm rounded-b-sm flex justify-center z-40">
        <span className="pt-[3px] text-base font-medium text-[#333]">
          {product.product_name}
        </span>
        <span className="pt-[3px] text-xs font-medium text-[#333]">
          ${product.price.toFixed(2)}
        </span>
      </div>
    </div>
  );
};

export default SaleItems;

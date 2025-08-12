import React from 'react'
import MenuCard from '../first/MenuCard'

const MenuRows = ({menuData}) => {
  return (
    <>
      <div className="row g-4 mt-2">
        {menuData.map((rowItems, rowIndex) => (
          <div className="row g-4 mt-2" key={`row-${rowIndex}`}>
            {rowItems.map(({ title, link, label }, idx) => (
              <MenuCard key={`${title}-${idx}`} title={title} link={link} label={label} />
            ))}
          </div>
        ))}
      </div>
    </>
  )
}

export default MenuRows
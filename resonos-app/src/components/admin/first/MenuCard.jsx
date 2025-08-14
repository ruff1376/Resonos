import React from 'react'

const MenuCard = ({ title, link, label }) => {
return (
  <div className="admin col-md-3">
    <div className="resonos-card">
      <div className="card-sm-title card-title">{title}</div>
      <a href={link} className="btn btn-sm mt-2 btn-outline-gold">
        {label}
      </a>
    </div>
  </div>
);

}

export default MenuCard
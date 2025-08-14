import React from 'react'
const card1 = ({ title, value}) => { 
return (
  <div className="admin col-md-3">
    <div className="resonos-card">
      <div className="card-title">{title}</div>
      <div className="card-value">{value}</div>
    </div>
  </div>
);

}

export default card1
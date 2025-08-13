import React from 'react'
import Card1 from '../first/Card1.jsx'

const StatusCards = ({ stats }) => {
  return (
    <>
      <div className="row g-4 mb-4">
          {stats.map(({ title, value }) => (
          <Card1 key={title} title={title} value={value} />
          ))}
      </div>

    </>
  )
}

export default StatusCards
import React from 'react';
import StatsCards from './second/StatusCards';


const Index = ({ stats }) => {
  return (
    <>
    <h1>admin components index</h1>
      <StatsCards stats={stats} />
    </>
  )
}

export default Index
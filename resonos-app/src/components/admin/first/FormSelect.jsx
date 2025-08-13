import React from 'react';

const FormSelect = ({
  label,
  name,
  value,
  onChange,
  options = [],
  required = false,
  className = 'form-select',
  containerClassName = 'col-md-4 text-start',
  ...rest
}) => (
<div className={`admin ${containerClassName}`}>
  <label className="form-label" htmlFor={name}>{label}</label>
  <select
    id={name}
    name={name}
    className={`form-select ${className || ''}`}
    value={value}
    onChange={onChange}
    required={required}
    {...rest}
  >
    {options.map(({ value: optVal, label: optLabel }) => (
      <option key={optVal} value={optVal}>{optLabel}</option>
    ))}
  </select>
</div>

);

export default FormSelect;

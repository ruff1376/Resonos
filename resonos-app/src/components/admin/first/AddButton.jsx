import React from 'react';

const AddButton = ({
  label = '+ 회원 추가',
  className = 'btn btn-gold btn-sm',
  onClick,
  type = 'button',
  id,
  style,
}) => {
  return (
    <div className="admin">
      <div className="mb-3 text-end">
        <button
          type={type}
          className={className}
          id={id}
        onClick={onClick}
        style={style}
      >
        {label}
      </button>
    </div>
    </div>
  );
};

export default AddButton;

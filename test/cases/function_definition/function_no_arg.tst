int foo()
  return 5
end
-- -- --
s(:statements,
  s(:function, :Integer,
    s(:name, :foo),
    s(:parameters),
    s(:statements,
      s(:return,
        s(:int, 5)))))

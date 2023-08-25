return
{
  s('curtime', f(function () return os.date '%D - %H:%M' end)),
},
{
  s('sametest', fmt([[example: {}, function: {}]], { i(1), same(1)}))
}


